var smallestDivisibleDigitProduct = function(n) {
    if (n === 1) return 1;
    let queue = [[1, "1"]];
    let visited = new Set();
    visited.add(1);

    while (queue.length > 0) {
        let [product, numStr] = queue.shift();

        for (let digit = 2; digit <= 9; digit++) {
            let newProduct = product * digit;
            if (newProduct > n) continue;

            if (n % newProduct === 0) {
                let newNumStr = numStr + digit;
                let newProduct2 = 1;
                for(let i = 0; i < newNumStr.length; i++){
                    newProduct2 *= parseInt(newNumStr[i]);
                }

                if (n % newProduct2 === 0) {
                    return newNumStr;
                }
            }

            if (!visited.has(newProduct)) {
                visited.add(newProduct);
                queue.push([newProduct, numStr + digit]);
            }
        }
    }

    return -1;
};