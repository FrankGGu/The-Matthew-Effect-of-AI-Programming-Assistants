class Solution:
    def changeDataType(self, data: List[Union[int, str]]) -> List[Union[int, str]]:
        return [int(x) if isinstance(x, str) and x.isdigit() else x for x in data]