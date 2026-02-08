class Solution:
    def getDynasty(self, year: int) -> str:
        # Define dynasties with their start and end years.
        # Years BC are represented as negative integers (e.g., 2070 BC is -2070).
        # Years AD are represented as positive integers.
        # The ranges are inclusive [start, end].
        # The list is ordered chronologically. For periods with overlapping dynasties,
        # the ranges are adjusted for simplicity to be non-overlapping,
        # typically prioritizing the later, more dominant, or unifying dynasty.
        # For "present" or future years, a large arbitrary end year like 9999 is used.

        dynasties = [
            ("Xia", -2070, -1600),
            ("Shang", -1600, -1046),
            ("Western Zhou", -1046, -771),
            ("Eastern Zhou", -770, -256), # Includes Spring and Autumn, Warring States periods
            ("Qin", -221, -207),
            ("Western Han", -206, 8),
            ("Xin", 9, 23),
            ("Eastern Han", 25, 220),
            ("Three Kingdoms", 220, 265), # Ends with the fall of Shu Han, before Western Jin's full establishment
            ("Western Jin", 265, 316),
            ("Eastern Jin", 317, 420),
            ("Southern and Northern Dynasties", 420, 589), # Period of disunity
            ("Sui", 581, 618),
            ("Tang", 618, 907),
            ("Five Dynasties and Ten Kingdoms", 907, 960), # Period of disunity
            ("Northern Song", 960, 1127),
            ("Southern Song", 1127, 1270), # Simplified to end before Yuan's establishment for clean non-overlap
            ("Yuan", 1271, 1368),
            ("Ming", 1368, 1644),
            ("Qing", 1644, 1912),
            ("Republic of China", 1912, 1949),
            ("People's Republic of China", 1949, 9999)
        ]

        for name, start, end in dynasties:
            if start <= year <= end:
                return name

        # If the year does not fall into any defined dynasty period
        return "Unknown"