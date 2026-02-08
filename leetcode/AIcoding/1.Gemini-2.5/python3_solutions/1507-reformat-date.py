class Solution:
    def reformatDate(self, date: str) -> str:
        month_map = {
            "Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04",
            "May": "05", "Jun": "06", "Jul": "07", "Aug": "08",
            "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12"
        }

        parts = date.split()
        day_str = parts[0]
        month_str = parts[1]
        year_str = parts[2]

        # Process day
        day_num_str = day_str[:-2]
        formatted_day = f"{int(day_num_str):02d}"

        # Process month
        formatted_month = month_map[month_str]

        # Process year
        formatted_year = year_str

        return f"{formatted_year}-{formatted_month}-{formatted_day}"