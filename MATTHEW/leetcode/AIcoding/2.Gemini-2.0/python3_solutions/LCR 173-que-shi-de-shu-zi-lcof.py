def attend_the_meeting(attendance_list: list[str], names: list[str]) -> list[str]:
    present = []
    attendance_set = set(attendance_list)
    for name in names:
        if name in attendance_set:
            present.append(name)
    return present