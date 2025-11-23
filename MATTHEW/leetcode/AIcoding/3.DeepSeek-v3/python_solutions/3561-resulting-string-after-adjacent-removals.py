class Solution:
    def resultString(self, s: str, indices: List[int]) -> str:
        s_list = list(s)
        for i in sorted(indices, reverse=True):
            if i < len(s_list):
                s_list.pop(i)
        return ''.join(s_list)