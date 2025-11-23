def haveConflict(event1, event2):
    return not (event1[1] < event2[0] or event2[1] < event1[0])