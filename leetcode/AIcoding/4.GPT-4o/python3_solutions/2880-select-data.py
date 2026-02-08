class Solution:
    def selectData(self, data: List[List[int]]) -> List[int]:
        return [x[0] for x in sorted(data, key=lambda x: (x[1], x[0]))]