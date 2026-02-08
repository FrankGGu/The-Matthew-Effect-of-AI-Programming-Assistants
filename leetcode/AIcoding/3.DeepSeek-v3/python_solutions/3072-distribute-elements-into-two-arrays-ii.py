class Solution:
    def resultArray(self, nums: List[int]) -> List[int]:
        arr1 = [nums[0]]
        arr2 = [nums[1]]
        sorted_arr1 = [nums[0]]
        sorted_arr2 = [nums[1]]

        for num in nums[2:]:
            cnt1 = len(sorted_arr1) - bisect.bisect_right(sorted_arr1, num)
            cnt2 = len(sorted_arr2) - bisect.bisect_right(sorted_arr2, num)

            if cnt1 > cnt2:
                arr1.append(num)
                bisect.insort(sorted_arr1, num)
            elif cnt1 < cnt2:
                arr2.append(num)
                bisect.insort(sorted_arr2, num)
            else:
                if len(arr1) <= len(arr2):
                    arr1.append(num)
                    bisect.insort(sorted_arr1, num)
                else:
                    arr2.append(num)
                    bisect.insort(sorted_arr2, num)

        return arr1 + arr2