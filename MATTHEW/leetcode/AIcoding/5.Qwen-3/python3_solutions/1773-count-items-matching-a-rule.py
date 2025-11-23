class Solution:
    def countMatches(self, items: List[str], ruleKey: str, ruleValue: str) -> int:
        index = 0
        if ruleKey == "name":
            index = 0
        elif ruleKey == "type":
            index = 1
        else:
            index = 2
        count = 0
        for item in items:
            if item.split(",")[index] == ruleValue:
                count += 1
        return count