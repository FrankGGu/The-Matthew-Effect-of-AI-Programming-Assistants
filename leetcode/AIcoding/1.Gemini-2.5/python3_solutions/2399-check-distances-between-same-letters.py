class Solution:
    def checkDistances(self, s: str, distances: list[int]) -> bool:
        first_occurrence_idx = [-1] * 26

        for i, char_code in enumerate(s):
            idx = ord(char_code) - ord('a')
            if first_occurrence_idx[idx] == -1:
                first_occurrence_idx[idx] = i
            else:
                calculated_distance = i - first_occurrence_idx[idx] - 1
                if calculated_distance != distances[idx]:
                    return False
        return True