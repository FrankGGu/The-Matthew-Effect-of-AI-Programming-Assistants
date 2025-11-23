import "fmt"

func angleClock(hour int, minutes int) float64 {
	hour = hour % 12
	hourAngle := float64(hour*30 + minutes/2)
	minuteAngle := float64(minutes * 6)

	angle := abs(hourAngle - minuteAngle)

	if angle > 180 {
		return 360 - angle
	}
	return angle
}

func abs(x float64) float64 {
	if x < 0 {
		return -x
	}
	return x
}