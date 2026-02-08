class Solution:
    def getMinSwaps(self, num: str, k: int) -> int:

        def next_permutation(s_list):
            n = len(s_list)
            i = n - 2
            while i >= 0 and s_list[i] >= s_list[i+1]:
                i -= 1

            if i == -1:
                return s_list

            j = n - 1
            while s_list[j] <= s_list[i]:
                j -= 1

            s_list[i], s_list[j] = s_list[j], s_list[i]

            left = i + 1
            right = n - 1
            while left < right:
                s_list[left], s_list[right] = s_list[right], s_list[left]
                left += 1
                right -= 1
            return s_list

        def min_adjacent_swaps(s1_str, s2_list):
            s1_list = list(s1_str)
            n = len(s1_list)
            swaps = 0

            for i in range(n):
                if s1_list[i] == s2_list[i]:
                    continue

                j = i + 1
                while j < n and s1_list[j] != s2_list[i]:
                    j += 1

                while j > i:
                    s1_list[j], s1_list[j-1] = s1_list[j-1], s1_list[j]
                    swaps += 1
                    j -= 1
            return swaps

        original_num_list = list(num)
        target_num_list = list(num)

        for _ in range(k):
            target_num_list = next_permutation(target_num_list)

        return min_adjacent_swaps(num, target_num_list)