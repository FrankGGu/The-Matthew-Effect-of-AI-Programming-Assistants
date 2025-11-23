class DataStream:

    def __init__(self, value: int, k: int):
        self.value = value
        self.k = k
        self.consecutive_count = 0

    def consec(self, num: int) -> bool:
        if num == self.value:
            self.consecutive_count += 1
        else:
            self.consecutive_count = 0

        return self.consecutive_count >= self.k