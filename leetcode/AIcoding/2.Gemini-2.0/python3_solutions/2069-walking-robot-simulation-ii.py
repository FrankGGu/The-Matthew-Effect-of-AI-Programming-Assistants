class Robot:

    def __init__(self, width: int, height: int):
        self.width = width
        self.height = height
        self.pos = [0, 0]
        self.dir = 0  # 0: East, 1: North, 2: West, 3: South
        self.perimeter = 2 * (width + height) - 4

    def step(self, num: int) -> None:
        num %= self.perimeter
        if num == 0 and self.perimeter > 0:
            num = self.perimeter

        while num > 0:
            if self.dir == 0:  # East
                move = min(num, self.width - 1 - self.pos[0])
                self.pos[0] += move
                num -= move
                if self.pos[0] == self.width - 1 and num > 0:
                    self.dir = 1
            elif self.dir == 1:  # North
                move = min(num, self.height - 1 - self.pos[1])
                self.pos[1] += move
                num -= move
                if self.pos[1] == self.height - 1 and num > 0:
                    self.dir = 2
            elif self.dir == 2:  # West
                move = min(num, self.pos[0])
                self.pos[0] -= move
                num -= move
                if self.pos[0] == 0 and num > 0:
                    self.dir = 3
            elif self.dir == 3:  # South
                move = min(num, self.pos[1])
                self.pos[1] -= move
                num -= move
                if self.pos[1] == 0 and num > 0:
                    self.dir = 0

    def getPos(self) -> List[int]:
        return self.pos

    def getDir(self) -> str:
        if self.dir == 0:
            return "East"
        elif self.dir == 1:
            return "North"
        elif self.dir == 2:
            return "West"
        else:
            return "South"