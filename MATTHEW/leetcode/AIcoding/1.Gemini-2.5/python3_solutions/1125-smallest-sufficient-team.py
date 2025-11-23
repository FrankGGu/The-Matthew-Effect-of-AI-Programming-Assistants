import collections

class Solution:
    def smallestSufficientTeam(self, req_skills: list[str], people: list[list[str]]) -> list[int]:
        n_skills = len(req_skills)
        skill_to_idx = {skill: i for i, skill in enumerate(req_skills)}

        target_mask = (1 << n_skills) - 1

        people_skill_masks = []
        for p_skills_list in people:
            current_person_mask = 0
            for skill in p_skills_list:
                if skill in skill_to_idx:
                    current_person_mask |= (1 << skill_to_idx[skill])
            people_skill_masks.append(current_person_mask)

        # dp[mask] stores the minimum number of people needed to achieve skill set 'mask'
        # dp_team[mask] stores the bitmask of people indices for that minimum
        dp = [float('inf')] * (1 << n_skills)
        dp_team = [0] * (1 << n_skills)

        dp[0] = 0 # 0 people for 0 skills

        for p_idx, p_skills_mask in enumerate(people_skill_masks):
            # Iterate through all skill masks achieved so far
            for s in range(1 << n_skills):
                if dp[s] == float('inf'): # If skill set 's' is not reachable, skip
                    continue

                # If we add the current person (p_idx) to the team for 's'
                new_s = s | p_skills_mask

                current_num_people = dp[s] + 1
                current_team_mask = dp_team[s] | (1 << p_idx)

                # Check if this new team is better (fewer people) for new_s
                if current_num_people < dp[new_s]:
                    dp[new_s] = current_num_people
                    dp_team[new_s] = current_team_mask

        final_team_mask = dp_team[target_mask]

        result = []
        for i in range(len(people)):
            if (final_team_mask >> i) & 1:
                result.append(i)

        return result