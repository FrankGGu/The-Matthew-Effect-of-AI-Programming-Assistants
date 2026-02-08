def convert_date_to_binary(date: str) -> str:
    month_map = {
        "Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04",
        "May": "05", "Jun": "06", "Jul": "07", "Aug": "08",
        "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12"
    }
    day, month, year = date.split()
    day = day[:-2]
    day = int(day)
    month = int(month_map[month])
    year = int(year)

    day_bin = bin(day)[2:].zfill(5)
    month_bin = bin(month)[2:].zfill(4)
    year_bin = bin(year)[2:].zfill(11)

    return year_bin + month_bin + day_bin