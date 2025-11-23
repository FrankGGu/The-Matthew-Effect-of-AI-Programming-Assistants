import itertools

class Solution:
    def shortestStringThatContainsThreeStrings(self, s1: str, s2: str, s3: str) -> str:

        def merge(str1: str, str2: str) -> str:
            # If one string already contains the other, return the longer one
            if str1 in str2:
                return str2
            if str2 in str1:
                return str1

            # Calculate overlap for str1 + str2
            overlap_len_1 = 0
            for k in range(min(len(str1), len(str2)), 0, -1):
                if str1[len(str1)-k:] == str2[:k]:
                    overlap_len_1 = k
                    break
            res1 = str1 + str2[overlap_len_1:]

            # Calculate overlap for str2 + str1
            overlap_len_2 = 0
            for k in range(min(len(str1), len(str2)), 0, -1):
                if str2[len(str2)-k:] == str1[:k]:
                    overlap_len_2 = k
                    break
            res2 = str2 + str1[overlap_len_2:]

            # Return the shorter one, or lexicographically smaller if lengths are equal
            if len(res1) < len(res2):
                return res1
            elif len(res2) < len(res1):
                return res2
            else:
                return min(res1, res2)

        strings = [s1, s2, s3]

        # Initialize ans with a string longer than max possible (3 * 100 = 300)
        # and lexicographically larger than any possible result.
        ans = "~" * 301 

        # Iterate through all 6 permutations of the three strings
        for p in itertools.permutations(range(3)):
            # p is a tuple like (0, 1, 2) representing indices of strings

            # First merge two strings (e.g., s_p0 and s_p1)
            temp_merged = merge(strings[p[0]], strings[p[1]])

            # Then merge the result with the third string (s_p2)
            current_res = merge(temp_merged, strings[p[2]])

            # Update overall answer based on length and lexicographical order
            if len(current_res) < len(ans):
                ans = current_res
            elif len(current_res) == len(ans):
                ans = min(ans, current_res)

        return ans