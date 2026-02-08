class Solution:
    def smallestSufficientTeam(self, req_skills: List[str], people: List[List[str]]) -> List[int]:
        skill_index = {skill: i for i, skill in enumerate(req_skills)}
        n = len(req_skills)
        target = (1 << n) - 1

        people_masks = []
        for person in people:
            mask = 0
            for skill in person:
                mask |= 1 << skill_index[skill]
            people_masks.append(mask)

        dp = {0: []}

        for i, mask in enumerate(people_masks):
            new_dp = {}
            for key in dp:
                new_key = key | mask
                if new_key not in dp or len(dp[key]) + 1 < len(dp[new_key]):
                    new_dp[new_key] = dp[key] + [i]
            for key in new_dp:
                if key not in dp or len(new_dp[key]) < len(dp[key]):
                    dp[key] = new_dp[key]

        return dp[target]