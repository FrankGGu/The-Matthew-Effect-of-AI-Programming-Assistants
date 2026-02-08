from collections import defaultdict
from itertools import combinations

class Solution:
    def smallestSufficientTeam(self, req_skills: List[str], people: List[List[str]]) -> List[int]:
        skill_to_index = {skill: i for i, skill in enumerate(req_skills)}
        n = len(req_skills)
        m = len(people)
        dp = {0: []}

        for i in range(m):
            person_skills = 0
            for skill in people[i]:
                if skill in skill_to_index:
                    person_skills |= 1 << skill_to_index[skill]

            for skills in list(dp.keys()):
                new_skills = skills | person_skills
                if new_skills not in dp or len(dp[new_skills]) > len(dp[skills]) + 1:
                    dp[new_skills] = dp[skills] + [i]

        return dp[(1 << n) - 1]