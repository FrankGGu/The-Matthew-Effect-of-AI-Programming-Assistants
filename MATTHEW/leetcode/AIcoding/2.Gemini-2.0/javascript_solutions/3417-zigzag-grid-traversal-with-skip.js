var findZigzagGridTraversal = function(rows, cols, skips) {
    const result = [];
    let row = 0;
    let col = 0;
    const skipped = new Set(skips.map(skip => skip[0] * cols + skip[1]));

    while (result.length < rows * cols) {
        result.push(row * cols + col);

        if (skipped.has(row * cols + col)) {
            if (row + 1 < rows && !skipped.has((row + 1) * cols + col)) {
                row++;
            } else if (col + 1 < cols && !skipped.has(row * cols + (col + 1))) {
                col++;
            } else {
                return [];
            }
            continue;
        }

        if ((row + col) % 2 === 0) {
            if (col + 1 < cols && !skipped.has(row * cols + (col + 1))) {
                col++;
            } else if (row + 1 < rows && !skipped.has((row + 1) * cols + col)) {
                row++;
            } else {
                if(row+1<rows && col+1<cols && skipped.has(row * cols + (col + 1)) && skipped.has((row + 1) * cols + col)){
                    let found = false;
                    for(let i=col+1; i<cols; i++){
                        if(!skipped.has(row * cols + i)){
                            col = i;
                            found = true;
                            break;
                        }
                    }
                    if(!found){
                        for(let i=row+1; i<rows; i++){
                            if(!skipped.has(i * cols + col)){
                                row = i;
                                found = true;
                                break;
                            }
                        }
                    }
                    if(!found) return [];

                }
                else return [];
            }
        } else {
            if (row + 1 < rows && !skipped.has((row + 1) * cols + col)) {
                row++;
            } else if (col + 1 < cols && !skipped.has(row * cols + (col + 1))) {
                col++;
            } else {
                if(row+1<rows && col+1<cols && skipped.has(row * cols + (col + 1)) && skipped.has((row + 1) * cols + col)){
                    let found = false;
                    for(let i=row+1; i<rows; i++){
                        if(!skipped.has(i * cols + col)){
                            row = i;
                            found = true;
                            break;
                        }
                    }
                    if(!found){
                        for(let i=col+1; i<cols; i++){
                            if(!skipped.has(row * cols + i)){
                                col = i;
                                found = true;
                                break;
                            }
                        }
                    }
                    if(!found) return [];
                }
                else return [];
            }
        }
    }

    return result;
};