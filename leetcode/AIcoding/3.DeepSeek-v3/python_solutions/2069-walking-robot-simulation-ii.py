class Robot:

    def __init__(self, width: int, height: int):
        self.width = width
        self.height = height
        self.pos = [0, 0]
        self.dir = 0
        self.dirs = [(1, 0), (0, 1), (-1, 0), (0, -1)]
        self.dir_names = ['East', 'North', 'West', 'South']
        self.perimeter = 2 * (width + height) - 4
        self.moved = False

    def step(self, num: int) -> None:
        if num == 0:
            return
        self.moved = True
        num %= self.perimeter
        if num == 0:
            num = self.perimeter
        for _ in range(num):
            nx, ny = self.pos[0] + self.dirs[self.dir][0], self.pos[1] + self.dirs[self.dir][1]
            while not (0 <= nx < self.width and 0 <= ny < self.height):
                self.dir = (self.dir + 1) % 4
                nx, ny = self.pos[0] + self.dirs[self.dir][0], self.pos[1] + self.dirs[self.dir][1]
            self.pos = [nx, ny]

    def getPos(self) -> List[int]:
        return self.pos

    def getDir(self) -> str:
        if not self.moved and self.pos == [0, 0]:
            return 'East'
        return self.dir_names[self.dir]