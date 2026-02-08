package main

func humidityInRange(temperature int, humidity int) bool {
    return temperature >= 20 && temperature <= 25 && humidity >= 40 && humidity <= 60
}