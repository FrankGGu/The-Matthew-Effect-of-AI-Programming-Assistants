class Solution:
    def minimumPeople(self, skills: List[List[int]], targetSkills: List[int]) -> int:
        from collections import Counter

        target_count = Counter(targetSkills)
        skill_count = Counter()

        for skill in skills:
            skill_count.update(skill)

        people_needed = 0

        for skill, count in target_count.items():
            if skill_count[skill] < count:
                people_needed += count - skill_count[skill]

        return people_needed