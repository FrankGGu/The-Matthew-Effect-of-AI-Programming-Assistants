class Solution:
    def minimumTotalCost(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        cost = 0
        same = 0
        freq = {}
        max_freq = 0
        max_num = -1
        indices = []

        for i in range(n):
            if nums1[i] == nums2[i]:
                cost += i
                same += 1
                if nums1[i] not in freq:
                    freq[nums1[i]] = 0
                freq[nums1[i]] += 1
                if freq[nums1[i]] > max_freq:
                    max_freq = freq[nums1[i]]
                    max_num = nums1[i]
                indices.append(i)

        if max_freq <= same - max_freq:
            return cost

        need = max_freq - (same - max_freq)

        for i in range(n):
            if nums1[i] != nums2[i] and nums1[i] != max_num and nums2[i] != max_num and need > 0:
                cost += i
                need -= 1

        if need > 0:
            return -1

        return cost