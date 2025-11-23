var countPoints = function(circles, toys) {
    let count = 0;
    for (let i = 0; i < toys.length; i++) {
        let toyX = toys[i][0];
        let toyY = toys[i][1];
        let inCircle = false;
        for (let j = 0; j < circles.length; j++) {
            let circleX = circles[j][0];
            let circleY = circles[j][1];
            let radius = circles[j][2];
            let distance = Math.sqrt(Math.pow(toyX - circleX, 2) + Math.pow(toyY - circleY, 2));
            if (distance <= radius) {
                inCircle = true;
                break;
            }
        }
        if (inCircle) {
            count++;
        }
    }
    return count;
};