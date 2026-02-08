def canType(words, hand):
    left = set("qwertasdfgzxcvb")
    right = set("yuiophjklnm")

    for word in words:
        for ch in word:
            if (ch in left and hand == "right") or (ch in right and hand == "left"):
                return False
    return True