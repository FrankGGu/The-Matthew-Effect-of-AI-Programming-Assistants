def isArtifactFromDynasty(artifacts, dynasty):
    dynasty_map = {
        "夏": (2070, 1600),
        "商": (1600, 1046),
        "周": (1046, 256),
        "秦": (221, 206),
        "汉": (206, 220),
        "三国": (220, 280),
        "晋": (265, 420),
        "南北朝": (420, 589),
        "隋": (589, 618),
        "唐": (618, 907),
        "五代十国": (907, 960),
        "宋": (960, 1279),
        "元": (1271, 1368),
        "明": (1368, 1644),
        "清": (1644, 1912),
    }

    if dynasty not in dynasty_map:
        return False

    start, end = dynasty_map[dynasty]

    for year in artifacts:
        if year < start or year >= end:
            return False

    return True