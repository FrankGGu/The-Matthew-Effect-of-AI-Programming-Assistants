class Solution:
    def distanceTraveled(self, mainTank: int, additionalTank: int) -> int:
        total_distance = 0
        while mainTank >= 5:
            total_distance += 50
            mainTank -= 5
            if additionalTank > 0:
                mainTank += 1
                additionalTank -= 1

        total_distance += mainTank * 10

        return total_distance