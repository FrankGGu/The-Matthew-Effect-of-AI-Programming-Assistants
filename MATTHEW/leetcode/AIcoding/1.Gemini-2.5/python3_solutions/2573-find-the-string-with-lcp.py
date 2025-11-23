class Solution:
    def findTheString(self, lcp: list[list[int]]) -> str:
        n = len(lcp)

        # DSU structure
        parent = list(range(n))
        chars = [None] * n # Stores the character assigned to the root of a DSU group

        # next_idx[k] stores the smallest index x >= k that has not been "merged" yet
        # (i.e., not yet part of an equivalence chain that skipped it)
        # This is used to efficiently iterate through ranges for union operations.
        next_idx = list(range(n + 1)) 

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i])
            return parent[i]

        def get_next(i):
            if next_idx[i] == i:
                return i
            next_idx[i] = get_next(next_idx[i])
            return next_idx[i]

        # Performs union of elements at index i and j.
        # Returns True if successful, False if a character conflict occurs.
        def union_eq(i, j):
            root_i = find(i)
            root_j = find(j)

            if root_i == root_j:
                return True

            # If both roots have characters assigned and they are different, it's a conflict
            if chars[root_i] is not None and chars[root_j] is not None and chars[root_i] != chars[root_j]:
                return False

            # Merge root_j into root_i (can be optimized with union by rank/size, but simple merge is fine for N=1000)
            if chars[root_j] is not None:
                chars[root_i] = chars[root_j]
            parent[root_j] = root_i
            return True

        # Apply all equality and inequality constraints from the LCP array
        for i in range(n):
            for j in range(i + 1, n):
                k = lcp[i][j]

                # Equality constraints: s[i+p] == s[j+p] for 0 <= p < k
                # Use get_next to efficiently iterate over indices that need to be unioned.
                curr_p_i = get_next(i)
                curr_p_j = get_next(j)

                while curr_p_i < i + k and curr_p_j < j + k:
                    if not union_eq(curr_p_i, curr_p_j):
                        return ""

                    # After union, curr_p_i and curr_p_j are effectively "merged" for this LCP constraint.
                    # Update their next_idx pointers to skip over them in future iterations for *this* LCP constraint.
                    next_idx[curr_p_i] = get_next(curr_p_i + 1)
                    next_idx[curr_p_j] = get_next(curr_p_j + 1)

                    # Re-evaluate curr_p_i and curr_p_j to jump to the next unmerged elements
                    curr_p_i = get_next(curr_p_i)
                    curr_p_j = get_next(curr_p_j)

                # Inequality constraint: s[i+k] != s[j+k] (if indices are valid)
                if i + k < n and j + k < n:
                    root_ik = find(i + k)
                    root_jk = find(j + k)

                    if root_ik == root_jk: # Contradiction: s[i+k] must be different from s[j+k]
                        return ""

                    # If both groups have characters, they must be different
                    if chars[root_ik] is not None and chars[root_jk] is not None and chars[root_ik] == chars[root_jk]:
                        return ""

        # Assign characters greedily to DSU roots that haven't been assigned yet
        next_char_code = ord('a')
        for i in range(n):
            root_i = find(i)
            if chars[root_i] is None:
                if next_char_code > ord('z'): # Ran out of distinct characters
                    return ""
                chars[root_i] = chr(next_char_code)
                next_char_code += 1

        # Construct the resulting string
        res_list = [''] * n
        for i in range(n):
            res_list[i] = chars[find(i)]
        s_str = "".join(res_list)

        # Verify the constructed string against the given LCP array
        my_lcp = [[0] * n for _ in range(n)]
        for i in range(n - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                if s_str[i] == s_str[j]:
                    if i + 1 < n and j + 1 < n:
                        my_lcp[i][j] = 1 + my_lcp[i+1][j+1]
                    else:
                        my_lcp[i][j] = 1
                else:
                    my_lcp[i][j] = 0

        for i in range(n):
            for j in range(n):
                if my_lcp[i][j] != lcp[i][j]:
                    return ""

        return s_str