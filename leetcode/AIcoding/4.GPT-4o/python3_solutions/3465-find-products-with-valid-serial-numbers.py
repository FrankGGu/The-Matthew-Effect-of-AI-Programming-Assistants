def validateSerialNumbers(products):
    def is_valid(serial):
        return len(serial) == 10 and serial.isalnum() and serial[0].isalpha()

    return [p for p in products if is_valid(p)]