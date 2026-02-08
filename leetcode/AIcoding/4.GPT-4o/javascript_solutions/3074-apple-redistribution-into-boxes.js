function minBoxes(numApples) {
    let boxes = 0;
    let apples = 0;

    while (apples < numApples) {
        boxes++;
        apples += boxes;
    }

    return boxes;
}