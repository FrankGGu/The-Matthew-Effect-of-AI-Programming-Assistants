class Solution:
    def maximumDistinctElements(self, nums: List[int], k: int) -> int:
        freq = {}
        for num in nums:
            freq[num] = freq.get(num, 0) + 1

        duplicates = []
        distinct = 0
        for num, count in freq.items():
            if count == 1:
                distinct += 1
            else:
                duplicates.append(count - 1)

        duplicates.sort()

        for dup in duplicates:
            if k >= dup:
                k -= dup
                distinct += 1
            else:
                break

        remaining_duplicates = sum(1 for count in freq.values() if count > 1) - len(duplicates) + sum(duplicates)
        if k > 0:
            distinct -= min(k, remaining_duplicates)

        return distinct