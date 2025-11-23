class Solution:
    def minimumTime(self, cars: str) -> int:
        illegal_goods = 0
        time = 0

        for i in range(len(cars)):
            if cars[i] == '1':
                illegal_goods += 1
                if illegal_goods == 1:
                    time += 2
                else:
                    time += 1
            else:
                time += 1

        return time