class Robot:

    def __init__(self, width: int, height: int):
        self.width = width
        self.height = height
        self.perimeter = 2 * (width - 1) + 2 * (height - 1)
        self.total_steps_taken = 0

    def step(self, num: int) -> None:
        if self.perimeter == 0:
            return
        self.total_steps_taken = (self.total_steps_taken + num) % self.perimeter

    def getPos(self) -> list[int]:
        if self.perimeter == 0:
            return [0, 0]

        s = self.total_steps_taken

        x, y = 0, 0

        len_e = self.width - 1
        len_n = self.height - 1
        len_w = self.width - 1
        len_s = self.height - 1

        if s < len_e: # East segment: (0,0) to (width-2,0)
            x = s
            y = 0
        elif s < len_e + len_n: # North segment: (width-1,0) to (width-1,height-2)
            s -= len_e
            x = self.width - 1
            y = s
        elif s < len_e + len_n + len_w: # West segment: (width-1,height-1) to (1,height-1)
            s -= (len_e + len_n)
            x = (self.width - 1) - s
            y = self.height - 1
        else: # South segment: (0,height-1) to (0,1)
            s -= (len_e + len_n + len_w)
            x = 0
            y = (self.height - 1) - s

        return [x, y]

    def getDir(self) -> str:
        if self.perimeter == 0:
            return "East"

        s = self.total_steps_taken

        # Special case: if at (0,0), it's always facing East to start a new cycle.
        # This occurs when s is 0.
        if s == 0:
            return "East"

        len_e = self.width - 1
        len_n = self.height - 1
        len_w = self.width - 1
        len_s = self.height - 1

        # The direction is determined by the segment the robot is currently on,
        # indicating where it will move next.
        # s is the number of steps taken to reach the current position.

        s_temp = s

        if s_temp < len_e: # Robot is on the East side (excluding (w-1,0)), moving East
            return "East"
        s_temp -= len_e

        if s_temp < len_n: # Robot is on the North side (excluding (w-1,h-1)), moving North
            return "North"
        s_temp -= len_n

        if s_temp < len_w: # Robot is on the West side (excluding (0,h-1)), moving West
            return "West"
        s_temp -= len_w

        # Robot is on the South side (excluding (0,0)), moving South
        return "South"