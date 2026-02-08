class Solution:
    def countMatchingSubarrays(self, nums: List[int], pattern: List[int]) -> int:
        n = len(nums)
        m = len(pattern)
        if n <= m:
            return 0

        # Convert the pattern to a string for KMP
        pattern_str = []
        for p in pattern:
            pattern_str.append(str(p))
        pattern_str = ','.join(pattern_str)

        # Build the lps array for KMP
        lps = [0] * m
        length = 0
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

        # Generate the transformed array for nums
        transformed = []
        for i in range(n - 1):
            if nums[i + 1] > nums[i]:
                transformed.append(1)
            elif nums[i + 1] == nums[i]:
                transformed.append(0)
            else:
                transformed.append(-1)
        transformed_str = []
        for num in transformed:
            transformed_str.append(str(num))
        transformed_str = ','.join(transformed_str)

        # KMP search
        count = 0
        i = 0  # index for transformed
        j = 0  # index for pattern
        len_transformed = len(transformed)
        while i < len_transformed:
            if transformed[i] == pattern[j]:
                i += 1
                j += 1
                if j == m:
                    count += 1
                    j = lps[j - 1]
            else:
                if j != 0:
                    j = lps[j - 1]
                else:
                    i += 1
        return count