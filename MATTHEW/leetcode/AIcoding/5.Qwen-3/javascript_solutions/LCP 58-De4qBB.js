function canPlaceBox(box, warehouse) {
    box.sort((a, b) => a - b);
    for (let i = 0; i < warehouse.length; i++) {
        let maxHeight = warehouse[i];
        for (let j = 0; j < box.length; j++) {
            if (box[j] <= maxHeight) {
                box.splice(j, 1);
                break;
            }
        }
    }
    return box.length === 0;
}