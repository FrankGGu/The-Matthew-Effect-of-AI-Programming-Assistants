var brokenCalc = function(startValue, target) {
    let operations = 0;

    while (target > startValue) {
        operations++;
        if (target % 2 === 0) {
            target /= 2;
        } else {
            target++;
        }
    }

    operations += (startValue - target);

    return operations;
};