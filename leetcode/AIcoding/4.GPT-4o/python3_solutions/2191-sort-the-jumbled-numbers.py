class Solution:
    def sortJumbled(self, mapping: List[int], nums: List[int]) -> List[int]:
        def map_number(num):
            mapped_str = ''.join(str(mapping[int(d)]) for d in str(num))
            return int(mapped_str) if mapped_str else float('inf')

        return sorted(nums, key=map_number)