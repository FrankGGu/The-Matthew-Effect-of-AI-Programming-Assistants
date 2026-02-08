class Robot:
    def __init__(self, width: int, height: int):
        self.width = width
        self.height = height
        self.x = 0
        self.y = 0
        self.direction = 0  # 0: right, 1: down, 2: left, 3: up
        self.visited = set()
        self.visited.add((0, 0))

    def move(self, steps: int) -> bool:
        for _ in range(steps):
            if self.direction == 0:  # moving right
                if self.x + 1 < self.width:
                    self.x += 1
                else:
                    return False
            elif self.direction == 1:  # moving down
                if self.y + 1 < self.height:
                    self.y += 1
                else:
                    return False
            elif self.direction == 2:  # moving left
                if self.x - 1 >= 0:
                    self.x -= 1
                else:
                    return False
            elif self.direction == 3:  # moving up
                if self.y - 1 >= 0:
                    self.y -= 1
                else:
                    return False
            self.visited.add((self.x, self.y))
        return True

    def turn(self, direction: str) -> None:
        if direction == "L":
            self.direction = (self.direction - 1) % 4
        elif direction == "R":
            self.direction = (self.direction + 1) % 4

    def clean(self) -> None:
        self.visited.clear()
        self.visited.add((self.x, self.y))

    def get_position(self) -> List[int]:
        return [self.x, self.y]