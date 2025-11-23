class Solution:
    def numSeniorCitizens(self, details: str) -> int:
        count = 0
        for i in range(0, len(details), 11):
            age = int(details[i+11:i+13])
            if age > 60:
                count += 1
        return count