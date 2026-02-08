class Solution:
    def handleQuery(self, nums1: List[int], nums2: List[int], queries: List[List[int]]) -> List[int]:
        n = len(nums1)
        total_sum = sum(nums2)
        result = []
        ones = sum(nums1)

        for query in queries:
            if query[0] == 1:
                l, r = query[1], query[2]
                ones -= sum(nums1[l:r+1])
                for i in range(l, r + 1):
                    nums1[i] = 1 - nums1[i]
                ones += sum(nums1[l:r+1])

            elif query[0] == 2:
                p, b = query[1], query[2]
                total_sum += ones * p

            else:
                result.append(total_sum)

        return result