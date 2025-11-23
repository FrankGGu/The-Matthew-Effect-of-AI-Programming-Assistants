class Solution:
    def buildArray(self, target: List[int], n: int) -> List[str]:
        res = []
        current = 1
        for num in target:
            while current < num:
                res.append("Push")
                current += 1
            res.append("Push")
            current += 1
        return res