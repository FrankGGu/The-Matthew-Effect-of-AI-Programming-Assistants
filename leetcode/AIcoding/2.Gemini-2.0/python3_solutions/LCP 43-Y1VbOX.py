import threading

class TrafficLight:
    def __init__(self):
        self.green_road = 1
        self.lock = threading.Lock()

    def carArrived(
        self,
        carId: int,
        roadId: int,
        direction: int,
        turnGreen: 'Callable[[], None]',
    ) -> None:
        with self.lock:
            if self.green_road != roadId:
                turnGreen()
                self.green_road = roadId