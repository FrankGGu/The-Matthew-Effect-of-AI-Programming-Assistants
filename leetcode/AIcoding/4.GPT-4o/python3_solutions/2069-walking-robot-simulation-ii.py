class Robot:
    def __init__(self, width: int, height: int):
        self.x = 0
        self.y = 0
        self.direction = 0
        self.width = width
        self.height = height
        self.boundary = 2 * (width + height)

    def step(self, num: int) -> None:
        for _ in range(num):
            if self.direction == 0:  # moving right
                if self.x < self.width - 1:
                    self.x += 1
                else:
                    self.direction = 1
                    self.y += 1
            elif self.direction == 1:  # moving up
                if self.y < self.height - 1:
                    self.y += 1
                else:
                    self.direction = 2
                    self.x -= 1
            elif self.direction == 2:  # moving left
                if self.x > 0:
                    self.x -= 1
                else:
                    self.direction = 3
                    self.y -= 1
            else:  # moving down
                if self.y > 0:
                    self.y -= 1
                else:
                    self.direction = 0
                    self.x += 1

    def get_position(self) -> List[int]:
        return [self.x, self.y]