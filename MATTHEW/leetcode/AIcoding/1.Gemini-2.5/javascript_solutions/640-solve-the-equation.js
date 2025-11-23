function solveEquation(equation) {
    function parseSide(side) {
        let coeffX = 0;
        let constant = 0;
        let currentNum = "";
        let sign = 1; // 1 for +, -1 for -

        // Prepend a '+' if the first char is not '+' or '-' to simplify parsing
        // This ensures every term effectively starts with a sign.
        if (side[0] !== '+' && side[0] !== '-') {
            side = '+' + side;
        }

        for (let i = 0; i < side.length; i++) {
            const char = side[i];

            if (char === '+' || char === '-') {
                // If currentNum is not empty, it means we just finished parsing a constant term
                if (currentNum !== "") {
                    constant += parseInt(currentNum) * sign;
                    currentNum = "";
                }
                sign = (char === '+') ? 1 : -1;
            } else if (char === 'x') {
                // If currentNum is empty, it's 'x' or '-x', implying a coefficient of 1
                let val = (currentNum === "") ? 1 : parseInt(currentNum);
                coeffX += val * sign;
                currentNum = "";
            } else {
                // It's a digit, append to currentNum
                currentNum += char;
            }
        }

        // After the loop, if currentNum is not empty, it's the last constant term
        if (currentNum !== "") {
            constant += parseInt(currentNum) * sign;
        }

        return [coeffX, constant];
    }

    const parts = equation.split('=');
    const leftSide = parts[0];
    const rightSide = parts[1];

    const [leftCoeffX, leftConstant] = parseSide(leftSide);
    const [rightCoeffX, rightConstant] = parseSide(rightSide);

    // Move all x terms to the left and constants to the right
    // Equation: leftCoeffX * x + leftConstant = rightCoeffX * x + rightConstant
    // Rearrange: (leftCoeffX - rightCoeffX) * x = rightConstant - leftConstant
    const finalCoeffX = leftCoeffX - rightCoeffX;
    const finalConstant = rightConstant - leftConstant;

    if (finalCoeffX === 0) {
        if (finalConstant === 0) {
            return "Infinite solutions";
        } else {
            return "No solution";
        }
    } else {
        return "x=" + (finalConstant / finalCoeffX);
    }
}