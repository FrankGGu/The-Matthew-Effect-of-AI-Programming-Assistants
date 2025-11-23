def countMatches(items, ruleKey, ruleValue):
    ruleIndex = {'type': 0, 'color': 1, 'name': 2}
    return sum(1 for item in items if item[ruleIndex[ruleKey]] == ruleValue)