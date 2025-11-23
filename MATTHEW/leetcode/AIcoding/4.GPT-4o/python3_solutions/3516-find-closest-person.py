class Solution:
    def findClosestPerson(self, persons: List[int], target: int) -> int:
        closest = float('inf')
        closest_person = -1

        for person in persons:
            if abs(person - target) < closest:
                closest = abs(person - target)
                closest_person = person
            elif abs(person - target) == closest:
                closest_person = min(closest_person, person)

        return closest_person