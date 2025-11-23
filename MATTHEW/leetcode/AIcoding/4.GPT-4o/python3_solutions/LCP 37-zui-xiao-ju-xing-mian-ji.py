def minArea(rectangles):
    min_x = min(rect[0] for rect in rectangles)
    max_x = max(rect[2] for rect in rectangles)
    min_y = min(rect[1] for rect in rectangles)
    max_y = max(rect[3] for rect in rectangles)
    return (max_x - min_x) * (max_y - min_y)