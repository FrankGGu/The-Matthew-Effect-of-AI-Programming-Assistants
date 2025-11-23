import datetime

class Solution:
    def convertDateToBinary(self, date: str) -> str:
        date_obj = datetime.date.fromisoformat(date)
        ordinal_num = date_obj.toordinal()
        binary_string = bin(ordinal_num)
        return binary_string[2:]