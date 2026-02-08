class Solution:
    def _compute_lps_array(self, pattern: list[int]) -> list[int]:
        m = len(pattern)
        lps = [0] * m
        length = 0  # length of the previous longest prefix suffix
        i = 1

        while i < m:
            if pattern[i] == pattern[length]:
                length += 1
                lps[i] = length
                i += 1
            else:
                if length != 0:
                    length = lps[length - 1]
                else:
                    lps[i] = 0
                    i += 1
        return lps

    def _kmp_search(self, text: list[int], pattern: list[int], lps: list[int]) -> int:
        n = len(text)
        m = len(pattern)

        if m == 0:
            return n + 1  # An empty pattern is considered to match at every position

        count = 0
        i = 0  # index for text
        j = 0  # index for pattern

        while i < n:
            if pattern[j] == text[i]:
                i += 1
                j += 1

            if j == m:
                count += 1
                j = lps[j - 1]
            elif i < n and pattern[j] != text[i]:
                if j != 0:
                    j = lps[j - 1]
                else:
                    i += 1
        return count

    def numberOfSubarrays(self, nums: list[int], pattern: list[int]) -> int:
        n = len(nums)
        m = len(pattern)

        if n <= m:
            return 0

        transformed_nums = []
        for i in range(n - 1):
            if nums[i+1] > nums[i]:
                transformed_nums.append(1)
            elif nums[i+1] < nums[i]:
                transformed_nums.append(-1)
            else:
                transformed_nums.append(0)

        lps_array = self._compute_lps_array(pattern)
        return self._kmp_search(transformed_nums, pattern, lps_array)