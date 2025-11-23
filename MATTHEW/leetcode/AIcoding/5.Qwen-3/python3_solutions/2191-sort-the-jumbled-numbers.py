class Solution:
    def sortJumbled(self, arr: List[int]) -> List[int]:
        def map_value(num):
            return int(''.join(sorted(str(num))))

        return sorted(arr, key=map_value)