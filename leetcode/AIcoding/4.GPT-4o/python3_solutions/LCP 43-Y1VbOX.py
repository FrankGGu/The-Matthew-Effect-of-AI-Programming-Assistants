class TrafficController:
    def __init__(self):
        self.red = 0
        self.green = 0

    def setRed(self, time: int) -> None:
        self.red = time

    def setGreen(self, time: int) -> None:
        self.green = time

    def getTrafficLight(self) -> str:
        if self.green > 0:
            return "Green"
        return "Red"

    def tick(self) -> None:
        if self.green > 0:
            self.green -= 1
        else:
            if self.red > 0:
                self.red -= 1