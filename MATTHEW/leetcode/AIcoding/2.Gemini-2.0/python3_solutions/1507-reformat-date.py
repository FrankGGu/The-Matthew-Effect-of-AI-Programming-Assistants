class Solution:
    def reformatDate(self, date: str) -> str:
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        day, month, year = date.split()
        day = int(day[:-2])
        month = months.index(month) + 1
        if month < 10:
            month = "0" + str(month)
        else:
            month = str(month)
        if day < 10:
            day = "0" + str(day)
        else:
            day = str(day)
        return year + "-" + month + "-" + day