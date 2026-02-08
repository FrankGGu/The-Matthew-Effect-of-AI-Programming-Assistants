class Solution:
    def checkArithmeticSubarrays(self, nums: list[int], l: list[int], r: list[int]) -> list[bool]:
        results = []
        for i in range(len(l)):
            start = l[i]
            end = r[i]

            subarray = nums[start : end + 1]

            if len(subarray) <= 2:
                results.append(True)
                continue

            subarray.sort()

            diff = subarray[1] - subarray[0]
            is_arithmetic = True

            for j in range(2, len(subarray)):
                if subarray[j] - subarray[j-1] != diff:
                    is_arithmetic = False
                    break

            results.append(is_arithmetic)

        return results