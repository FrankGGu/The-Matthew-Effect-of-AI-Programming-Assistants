class Solution:
    def countMatches(self, items: list[list[str]], ruleKey: str, ruleValue: str) -> int:
        key_map = {
            "type": 0,
            "color": 1,
            "name": 2
        }

        target_index = key_map[ruleKey]
        count = 0

        for item in items:
            if item[target_index] == ruleValue:
                count += 1

        return count