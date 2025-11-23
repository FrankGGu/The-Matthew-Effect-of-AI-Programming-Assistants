class Solution:
    def subarrayBitwiseORs(self, arr: List[int]) -> int:
        ans = set()
        curr = set()
        for x in arr:
            new_curr = {x}
            for y in curr:
                new_curr.add(x | y)
            ans |= new_curr
            curr = new_curr
        return len(ans)