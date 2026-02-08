class Solution:
    def distanceTraveled(self, mainTank: int, additionalTank: int) -> int:
        distance = 0
        while mainTank >= 5 and additionalTank > 0:
            distance += 50
            mainTank -= 5
            additionalTank -= 1
            mainTank += 1
        distance += mainTank * 10
        return distance