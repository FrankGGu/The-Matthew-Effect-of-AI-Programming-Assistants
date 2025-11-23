from collections import deque

class Solution:
    def minReverseOperations(self, n: int, p: int, banned: List[int], k: int) -> List[int]:
        banned_set = set(banned)
        res = [-1] * n
        res[p] = 0
        if k == 1:
            return res

        q = deque([p])
        # We use two lists to represent the available nodes for even and odd positions
        # Since after a reverse operation of size k, the parity of the position changes if k is odd
        # So we can split the available nodes into two groups: even and odd
        # We can use a list of sets for O(1) removal and iteration
        # But for Python, using a list and marking as visited is more efficient
        # So we use a list to represent the remaining nodes, and skip the banned and visited ones
        # We can use a Union-Find (Disjoint Set Union) to skip the visited nodes efficiently
        # But here for simplicity, we use a list and a pointer array to skip the visited nodes
        # Initialize the available nodes
        # We need to find the available nodes for each step
        # The available nodes are those not banned and not visited
        # We can use two pointers for even and odd positions
        # Initialize the pointers
        # We can use a list to represent the next available node
        parent = list(range(n + 2))  # n+2 to avoid index out of range

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            pu = find(u)
            pv = find(v)
            if pu != pv:
                parent[pu] = pv

        for num in banned:
            res[num] = -1
            union(num, num + 1)

        union(p, p + 1)

        while q:
            u = q.popleft()
            # The possible positions after reverse are in [L, R]
            # L = max(u - k + 1, 0)
            # R = min(u, n - k)
            # The actual positions after reverse are u - k + 1 + i + (k - 1 - i) = u - k + 1 + k - 1 = u
            # Wait, no. The new position is i + (k - 1 - (original_pos - start))
            # original_pos is u, start is s, then new_pos is s + (k - 1 - (u - s)) = s + k - 1 - u + s = 2s + k - 1 - u
            # So s can be in [max(u - (k - 1), 0), min(u, n - k)]
            # So the new_pos is in [2*max(u - (k - 1), 0) + k - 1 - u, 2*min(u, n - k) + k - 1 - u]
            # Let's compute the min and max s
            low = max(u - k + 1, 0)
            high = min(u, n - k)
            # The new positions are 2*s + k - 1 - u for s in [low, high]
            # So the new_pos range is [2*low + k - 1 - u, 2*high + k - 1 - u]
            # But since s increases by 1, new_pos increases by 2
            # So the new_pos are in [low_new, high_new] with step 2
            low_new = 2 * low + k - 1 - u
            high_new = 2 * high + k - 1 - u
            # So the parity is the same as low_new
            current_parity = low_new % 2
            # The nodes we can move to are in [low_new, high_new] with step 2
            # We need to find all nodes in this range that are not banned and not visited
            # We can use the find function to skip the visited nodes
            start = low_new
            end = high_new
            # Adjust start and end to be within [0, n-1]
            start = max(start, 0)
            end = min(end, n - 1)
            # The current node is start, start + 2, ..., end
            # We can iterate through them using the find function
            current = start
            while current <= end:
                if res[current] == -1:
                    res[current] = res[u] + 1
                    q.append(current)
                    union(current, current + 1)
                # Find the next available node
                current = find(current + 2)
                if current > end:
                    break
        return res