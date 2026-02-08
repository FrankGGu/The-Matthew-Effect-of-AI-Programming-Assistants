class Solution:
    def smallestSufficientTeam(self, req_skills: List[str], people: List[List[str]]) -> List[int]:
        n = len(req_skills)
        m = len(people)
        skill_index = {skill: i for i, skill in enumerate(req_skills)}
        people_skills = [0] * m
        for i in range(m):
            for skill in people[i]:
                if skill in skill_index:
                    people_skills[i] |= (1 << skill_index[skill])

        dp = {0: []}
        for i in range(m):
            person_skills = people_skills[i]
            for mask, team in list(dp.items()):
                new_mask = mask | person_skills
                new_team = team + [i]
                if new_mask not in dp or len(new_team) < len(dp[new_mask]):
                    dp[new_mask] = new_team

        return dp[(1 << n) - 1]